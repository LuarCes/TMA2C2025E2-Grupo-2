package com.unla.tm_tp_airbnb.controller;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {

	@GetMapping("/")
	public String index() {
		// Redirige directamente al listado de alojamientos
		return "redirect:/property/properties";
	}
}