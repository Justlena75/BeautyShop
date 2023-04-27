package com.example.beautyshop.controllers;

import com.example.beautyshop.enumm.Status;
import com.example.beautyshop.models.*;
import com.example.beautyshop.repositories.CartRepository;
import com.example.beautyshop.repositories.OrderPersonRepository;
import com.example.beautyshop.repositories.OrderRepository;
import com.example.beautyshop.repositories.ProductRepository;
import com.example.beautyshop.security.PersonDetails;
import com.example.beautyshop.services.PersonService;
import com.example.beautyshop.services.ProductService;
import com.example.beautyshop.util.PersonValidator;
import jakarta.validation.Valid;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class MainController {
    private final PersonValidator personValidator;
    private final PersonService personService;
    private final ProductService productService;
    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final OrderPersonRepository orderPersonRepository;
    public MainController(PersonValidator personValidator, PersonService personService, ProductService productService, ProductRepository productRepository, CartRepository cartRepository, OrderRepository orderRepository, OrderPersonRepository orderPersonRepository) {
        this.personValidator = personValidator;
        this.personService = personService;
        this.productService = productService;
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.orderRepository = orderRepository;
        this.orderPersonRepository = orderPersonRepository;
    }

    @GetMapping("/person account")
    public String index(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();//получаем объект аутентифкации
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        String role = personDetails.getPerson().getRole();
        String nameUser = personDetails.getPerson().getNameUser();
        if(role.equals("ROLE_ADMIN")){
            return "redirect:/admin";
        }
        model.addAttribute("personName", nameUser);
        model.addAttribute("products", productService.getAllProduct());
        return "/user/index";
    }

    @GetMapping("/registration")
    public String registration(@ModelAttribute("person") Person person){
        return "registration";
    }

    @PostMapping("/registration")
    public String resultRegistration(@ModelAttribute("person") @Valid Person person, BindingResult bindingResult){
        personValidator.validate(person, bindingResult);
        if(bindingResult.hasErrors()){
            return "registration";
        }
        personService.register(person);
        return "redirect:/person account";
    }

    @GetMapping("/person account/product/info/{id}")
    public String infoProduct(@PathVariable("id") int id, Model model){
        model.addAttribute("product", productService.getProductId(id));
        return "/user/infoProduct";
    }

    @PostMapping("/person account/product/search")
    public String productSearch(@RequestParam("search") String search, @RequestParam("ot") String ot, @RequestParam("do") String Do, @RequestParam(value = "price", required = false, defaultValue = "") String price, @RequestParam(value = "contract", required = false, defaultValue = "")String contract, Model model){
        model.addAttribute("products", productService.getAllProduct());
        if(!ot.isEmpty() & !Do.isEmpty()){
            if(!price.isEmpty()){
                if(price.equals("sorted_by_ascending_price")) {
                    if (!contract.isEmpty()) {
                        if (contract.equals("serum")) {
                            model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 1));
                        } else if (contract.equals("cream")) {
                            model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 2));
                        } else if (contract.equals("toner")) {
                            model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 3));
                        }
                    } else {
                        model.addAttribute("search_product", productRepository.findByTitleOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
                    }
                } else if(price.equals("sorted_by_descending_price")){
                    if(!contract.isEmpty()){
                        System.out.println(contract);
                        if(contract.equals("serum")){
                            model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 1));
                        }else if (contract.equals("cream")) {
                            model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 2));
                        } else if (contract.equals("toner")) {
                            model.addAttribute("search_product", productRepository.findByTitleAndCategoryOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 3));
                        }
                    }  else {
                        model.addAttribute("search_product", productRepository.findByTitleOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
                    }
                }
            } else {
                model.addAttribute("search_product", productRepository.findByTitleAndPriceGreaterThanEqualAndPriceLessThanEqual(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
            }
        } else {
            model.addAttribute("search_product", productRepository.findByTitleContainingIgnoreCase(search));
        }
        model.addAttribute("value_search", search);
        model.addAttribute("value_price_ot", ot);
        model.addAttribute("value_price_do", Do);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(authentication.isAuthenticated()){
            PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
            model.addAttribute("personName",personDetails.getPerson().getNameUser());
            return "/user/index";
        }
        return "/product/product";
    }

    @GetMapping("/cart/add/{id}")
    public String addProductInCart(@PathVariable("id") int id, Model model){
        // Получаем продукт по id
        Product product = productService.getProductId(id);
        // Извлекаем объект аутентифицированного пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        // Извлекаем id пользователя из объекта
        int id_person = personDetails.getPerson().getId();
        Cart cart = new Cart(id_person, product.getId());
        cartRepository.save(cart);
        return "redirect:/person account";
    }

    @GetMapping("/cart")
    public String cart(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        // Извлекаем id пользователя из объекта
        int id_person = personDetails.getPerson().getId();

        List<Cart> cartList = cartRepository.findByPersonId(id_person);
        List<Product> productList = new ArrayList<>();

        // Получаем продукты из корзины по id товара
        for (Cart cart: cartList) {
            productList.add(productService.getProductId(cart.getProductId()));
        }

        // Вычисление итоговой цена
        float price = 0;
        for (Product product: productList) {
            price += product.getPrice();
        }
        model.addAttribute("price", price);
        model.addAttribute("cart_product", productList);
        return "/user/cart";
    }

    @GetMapping("/cart/delete/{id}")
    public String deleteProductFromCart(Model model, @PathVariable("id") int id){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        // Извлекаем id пользователя из объекта
        int id_person = personDetails.getPerson().getId();
        List<Cart> cartList = cartRepository.findByPersonId(id_person);
        List<Product> productList = new ArrayList<>();
        // Получаем продукты из корзины по id товара
        for (Cart cart: cartList) {
            productList.add(productService.getProductId(cart.getProductId()));
        }
        cartRepository.deleteCartByProductId(id);
        return "redirect:/cart";
    }

    @GetMapping("/order/create")
    public String order(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        // Извлекаем id пользователя из объекта
        int id_person = personDetails.getPerson().getId();

        List<Cart> cartList = cartRepository.findByPersonId(id_person);
        List<Product> productList = new ArrayList<>();

        // Получаем продукты из корзины по id товара
        for (Cart cart: cartList) {
            productList.add(productService.getProductId(cart.getProductId()));
        }

        // Вычисление итоговой цена
        float price = 0;
        for (Product product: productList) {
            price += product.getPrice();
        }

        String uuid = UUID.randomUUID().toString();
        for(Product product : productList){
            Order newOrder = new Order(uuid, product, personDetails.getPerson(), 1, product.getPrice(), Status.Оформлен);
            orderRepository.save(newOrder);
            cartRepository.deleteCartByProductId(product.getId());
        }
        if (price>0){
            OrderPerson newOrderPerson = new OrderPerson(uuid, personDetails.getPerson(), price, Status.Оформлен);
            orderPersonRepository.save(newOrderPerson);
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orderUser(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        List<Order> orderList = orderRepository.findByPerson(personDetails.getPerson());
         model.addAttribute("orders", orderList);
         return "/user/orders";
    }

    @GetMapping("/orders/delete")
    public String orderDelete(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); //получаем пользователя который аутентифицыровался
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        int id_person = personDetails.getPerson().getId(); //получаем id-шник аутентифицированного пользователя
        orderRepository.deleteOrdersByPersonId(id_person);//удаляем лист заказов по id пользователя
        List<Order> orderList = orderRepository.findByPerson(personDetails.getPerson()); //получаем лист заказов по пользователю
        model.addAttribute("orders",orderList);//отправляем в html-ку пустой лист
        return "/user/orders";
    }
}
