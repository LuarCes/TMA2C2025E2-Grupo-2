package com.unla.tm_tp_airbnb.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.unla.tm_tp_airbnb.dto.PropertyDTO;
import com.unla.tm_tp_airbnb.model.Property;
import com.unla.tm_tp_airbnb.model.PropertyImage;
import com.unla.tm_tp_airbnb.model.Review;
import com.unla.tm_tp_airbnb.serviceInterface.PropertyImageService;
import com.unla.tm_tp_airbnb.serviceInterface.PropertyService;
import com.unla.tm_tp_airbnb.serviceInterface.ReviewService;
import com.unla.tm_tp_airbnb.serviceInterface.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/property")
public class PropertyController {

	@Autowired
	private PropertyService propertyService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private UserService userService;

	@Autowired
	private PropertyImageService propertyImageService;

	@GetMapping("/{id}")
	public String showPropertyDetail(@PathVariable Long id, HttpSession session, Model model) {
		Optional<Property> property = propertyService.findById(id);
		Long userId = (Long) session.getAttribute("userId");

		if (property.isPresent()) {
			model.addAttribute("property", property.get());
			List<Review> reviews = reviewService.findByPropertyId(id);
			model.addAttribute("reviews", reviews);
			List<Property> favorites = userService.getFavorites(userId);
			boolean isFavorite = favorites.stream().anyMatch(fav -> fav.getId().equals(property.get().getId()));
			model.addAttribute("isFavorite", isFavorite);
		}

		return "property/property-detail";
	}

	@GetMapping("/properties")
	public String listProperties(@RequestParam(required = false) String filter,
			@RequestParam(required = false) String location,
			@RequestParam(required = false) Integer maxGuests,
			@RequestParam(required = false) Double priceMin,
			@RequestParam(required = false) Double priceMax,
			Model model) {

		boolean hasAny = (filter != null && !filter.isBlank()) ||
				(location != null && !location.isBlank()) ||
				maxGuests != null || priceMin != null || priceMax != null;

		List<Property> properties = hasAny
				? propertyService.findByFilters(filter, location, maxGuests, priceMin, priceMax)
				: propertyService.findAll();

		model.addAttribute("properties", properties);
		return "property/properties";
	}

	@GetMapping("/properties-user")
	public String listPropertiesUsers(HttpSession session, Model model) {
		Long id = (Long) session.getAttribute("userId");
		List<Property> properties = propertyService.findByHostId(id);
		model.addAttribute("properties", properties);
		return "property/properties-user";
	}

	@GetMapping("/new")
	public String create(Model model) {
		Property property = new Property();
		model.addAttribute("property", property);
		return "property/property-form";
	}

	@PostMapping("/save")
	public String saveProperty(@ModelAttribute PropertyDTO propertyDTO,
			@RequestParam("propertyImages") MultipartFile[] imageFiles, HttpSession session) {
		if (propertyDTO.getRating() == null) {
			propertyDTO.setRating(0.0);
		}

		Property property = new Property();
		property.setTitle(propertyDTO.getTitle());
		Long userId = (Long) session.getAttribute("userId");
		property.setHost(userService.findById(userId).get());
		property.setImages(new ArrayList<>());
		property.setCreatedAt(LocalDate.now());
		property.setDescription(propertyDTO.getDescription());
		property.setMaxGuests(propertyDTO.getMaxGuests());
		property.setPricePerNight(propertyDTO.getPricePerNight());
		property.setLocation(propertyDTO.getLocation());
		property.setRating(propertyDTO.getRating());

		String uploadDir = "src/main/resources/static/assets/";

		for (MultipartFile image : imageFiles) {
			if (image != null && !image.isEmpty()) {
				try {
					String fileName = image.getOriginalFilename();
					Path path = Paths.get(uploadDir + fileName);
					Files.createDirectories(path.getParent());
					image.transferTo(path);

					PropertyImage propertyImage = new PropertyImage();
					propertyImage.setImageUrl(fileName);
					propertyImage.setProperty(property);
					propertyImage.setUploadedAt(LocalDate.now());

					property.getImages().add(propertyImage);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		propertyService.save(property);

		for (PropertyImage image : property.getImages()) {
			propertyImageService.save(image);
		}

		return "redirect:/property/properties-user";
	}

	@GetMapping("/favorites/{propertyId}")
	public String toggleFavorite(@PathVariable("propertyId") Long propertyId, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/login";
		}

		List<Property> favorites = userService.getFavorites(userId);
		boolean alreadyFavorite = favorites.stream()
				.anyMatch(fav -> fav.getId().equals(propertyId));

		if (alreadyFavorite) {
			userService.removeFavorite(userId, propertyId);
		} else {
			userService.addFavorite(userId, propertyId);
		}

		return "redirect:/property/" + propertyId;
	}

	@GetMapping("/favorites")
	public String listFavorites(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		List<Property> favorites = userService.getFavorites(userId);
		model.addAttribute("properties", favorites);
		return "property/favorites";
	}

}
