package com.unla.tm_tp_airbnb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unla.tm_tp_airbnb.model.Property;
import com.unla.tm_tp_airbnb.repository.PropertyRepository;
import com.unla.tm_tp_airbnb.serviceInterface.PropertyService;

@Service
public class PropertyServiceImpl implements PropertyService {

	@Autowired
	private PropertyRepository propertyRepository;

	public List<Property> findAll() {
		return propertyRepository.findAll();
	}

	public Optional<Property> findById(Long id) {
		return propertyRepository.findById(id);
	}

	public Property save(Property property) {
		return propertyRepository.save(property);
	}

	public void delete(Long id) {
		propertyRepository.deleteById(id);
	}

	@Override
	public List<Property> findByLocationContainingIgnoreCase(String query) {
		return propertyRepository.findByLocationContainingIgnoreCase(query);
	}

	@Override
	public List<Property> findByRatingGreaterThan(double rating) {
		return propertyRepository.findByRatingGreaterThan(rating);
	}

	@Override
	public List<Property> findByTitleContainingIgnoreCase(String title) {
		return propertyRepository.findByTitleContainingIgnoreCase(title);
	}

	@Override
	public List<Property> findByHostId(Long id) {
		return propertyRepository.findByHostId(id);
	}

	@Override
	public List<Property> findByFilters(String type, String location, Integer maxGuests, Double priceMin, Double priceMax) {

		if (priceMin == null)
			priceMin = 0.0;
		if (priceMax == null)
			priceMax = Double.MAX_VALUE;

		Integer guests = (maxGuests != null) ? maxGuests : Integer.MAX_VALUE;

		String typeParam = (type != null && !type.isBlank()) ? type : null;
		String locParam = (location != null && !location.isBlank()) ? location : null;

		return propertyRepository.search(typeParam, locParam, guests, priceMin, priceMax);
	}

	@Override
    public void toggleStatus(Long propertyId) {
        Property property = propertyRepository.findById(propertyId)
            .orElseThrow(() -> new RuntimeException("Propiedad no encontrada"));
        
        if ("ACTIVE".equals(property.getStatus())) {
            property.setStatus("PAUSED");
        } else {
            property.setStatus("ACTIVE");
        }
        
        propertyRepository.save(property);
    }

    @Override
    public List<Property> findActiveProperties() {
        return propertyRepository.findByStatus("ACTIVE");
    }

    @Override
    public List<Property> findByHostIdAndStatus(Long hostId, String status) {
        if (status != null && !status.isEmpty()) {
            return propertyRepository.findByHostIdAndStatus(hostId, status);
        }
        return propertyRepository.findByHostId(hostId);
    }
}
