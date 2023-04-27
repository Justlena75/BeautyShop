package com.example.beautyshop.services;

import com.example.beautyshop.models.Order;
import com.example.beautyshop.models.Product;
import com.example.beautyshop.repositories.OrderRepository;
import com.example.beautyshop.repositories.PersonRepository;
import com.example.beautyshop.repositories.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final PersonRepository personRepository;


    public OrderService(OrderRepository orderRepository, ProductRepository productRepository, PersonRepository personRepository) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.personRepository = personRepository;
    }

    public List<Order> getAllOrders(float price) {
        return orderRepository.findAll();
    }  //???

    @Transactional
    public void deleteOrder(int id) {
        orderRepository.deleteById(id);
    }

    @Transactional
    public void editStatusOrder(int id, Order order) {
        order.setId(id);
        orderRepository.save(order);
    }

}
