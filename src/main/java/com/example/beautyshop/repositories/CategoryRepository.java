package com.example.beautyshop.repositories;

import com.example.beautyshop.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    com.example.beautyshop.models.Category findByName(String name);
}
