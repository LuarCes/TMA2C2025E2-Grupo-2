package com.unla.tm_tp_airbnb.serviceInterface;

import java.util.List;
import java.util.Optional;

import com.unla.tm_tp_airbnb.model.Property;
import com.unla.tm_tp_airbnb.model.User;

public interface UserService {
	User save(User user);

	Optional<User> findById(Long id);

	List<User> findAll();

	void delete(Long id);

	Optional<User> findByEmailAndPasswordHash(String email, String passwordHash);

	Optional<User> findByEmail(String email);

	List<Property> getFavorites(Long userId);

	void addFavorite(Long userId, Long propertyId);

	void removeFavorite(Long userId, Long propertyId); // 👈 agregar esto


}
