package com.unla.tm_tp_airbnb.controller;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.unla.tm_tp_airbnb.model.Property;
import com.unla.tm_tp_airbnb.model.Review;
import com.unla.tm_tp_airbnb.model.User;
import com.unla.tm_tp_airbnb.serviceInterface.PropertyService;
import com.unla.tm_tp_airbnb.serviceInterface.ReviewService;
import com.unla.tm_tp_airbnb.serviceInterface.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private PropertyService propertyService;

	@Autowired
	private UserService userService;

	// POST /reviews/property/{propertyId}
	@PostMapping("/reviews/property/{propertyId}")
	public String createTextReview(
			@PathVariable Long propertyId,
			String comment, // name="comment" en el formulario
			HttpSession session,
			RedirectAttributes ra) {

		// Debe estar logueado
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			ra.addFlashAttribute("reviewError", "Debes iniciar sesión para enviar una reseña.");
			return "redirect:/login";
		}

		// Validaciones negocio: no vacío y ≤ 500
		if (comment == null || comment.trim().isEmpty()) {
			ra.addFlashAttribute("reviewError", "El comentario no puede estar vacío.");
			return "redirect:/property/" + propertyId;
		}
		if (comment.length() > 500) {
			ra.addFlashAttribute("reviewError", "El comentario no puede superar los 500 caracteres.");
			return "redirect:/property/" + propertyId;
		}

		Optional<User> guestOpt = userService.findById(userId);
		Optional<Property> propOpt = propertyService.findById(propertyId);
		if (guestOpt.isEmpty() || propOpt.isEmpty()) {
			ra.addFlashAttribute("reviewError", "No fue posible asociar la reseña al usuario o a la propiedad.");
			return "redirect:/property/" + propertyId;
		}

		Review review = new Review();
		review.setGuest(guestOpt.get());
		review.setProperty(propOpt.get());
		review.setComment(comment.trim());
		review.setCreatedAt(LocalDate.now());
		// No usamos estrellas: no seteamos rating

		reviewService.save(review);

		ra.addFlashAttribute("reviewOk", "Reseña enviada.");
		return "redirect:/property/" + propertyId;
	}
}
