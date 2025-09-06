package com.unla.tm_tp_airbnb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import com.unla.tm_tp_airbnb.model.User;
import com.unla.tm_tp_airbnb.serviceInterface.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mi-perfil")
public class ProfileController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String showProfile(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        User currentUser = userService.findById(userId).get();
        model.addAttribute("currentUser", currentUser);
        return "user/profile";
    }

    @PostMapping("/actualizar")
    public String updateProfile(@ModelAttribute User user, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId != null && userId.equals(user.getId())) {
            Optional<User> existingUser = userService.findById(userId);
            if (existingUser.isPresent()) {
                User userToUpdate = existingUser.get();
                userToUpdate.setName(user.getName());
                userService.save(userToUpdate);
            }
        }
        return "redirect:/mi-perfil";
    }

}