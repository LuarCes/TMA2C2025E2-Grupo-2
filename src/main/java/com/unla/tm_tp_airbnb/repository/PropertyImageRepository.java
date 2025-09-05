package com.unla.tm_tp_airbnb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.unla.tm_tp_airbnb.model.PropertyImage;

public interface PropertyImageRepository extends JpaRepository<PropertyImage, Long> {
}