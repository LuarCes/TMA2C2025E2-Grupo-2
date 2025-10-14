package com.unla.tm_tp_airbnb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.unla.tm_tp_airbnb.model.Property;

public interface PropertyRepository extends JpaRepository<Property, Long> {
	List<Property> findByLocationContainingIgnoreCase(String location);

	List<Property> findByRatingGreaterThan(double rating);

	List<Property> findByTitleContainingIgnoreCase(String title);

	List<Property> findByHostId(Long id);

    @Query("""
            SELECT p FROM Property p
            WHERE p.status = 'ACTIVE'
            AND (:type IS NULL OR LOWER(p.title) LIKE LOWER(CONCAT('%', :type, '%')))
            AND (:location IS NULL OR LOWER(p.location) LIKE LOWER(CONCAT('%', :location, '%')))
            AND p.maxGuests <= :maxGuests
            AND p.pricePerNight BETWEEN :priceMin AND :priceMax
            """)
	List<Property> search(@Param("type") String type, @Param("location") String location, @Param("maxGuests") Integer maxGuests, @Param("priceMin") Double priceMin, @Param("priceMax") Double priceMax);

	@Query(value = "SELECT p.* " + "FROM property AS p " + "INNER JOIN favorites AS uf ON p.id = uf.property_id "
			+ "WHERE uf.user_id = :userId", nativeQuery = true)
	List<Property> findFavoritesByUserId(@Param("userId") Long userId);

	@Query("SELECT p FROM Property p WHERE p.status = 'ACTIVE'")
    List<Property> findAllActive();

	List<Property> findByStatus(String status);
    
    List<Property> findByHostIdAndStatus(Long hostId, String status);
}