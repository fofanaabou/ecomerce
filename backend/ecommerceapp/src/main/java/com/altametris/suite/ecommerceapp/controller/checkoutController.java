package com.altametris.suite.ecommerceapp.controller;

import com.altametris.suite.ecommerceapp.dto.PaymentInfo;
import com.altametris.suite.ecommerceapp.dto.Purchase;
import com.altametris.suite.ecommerceapp.dto.PurchaseResponse;
import com.altametris.suite.ecommerceapp.service.CheckoutService;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/checkout")
public class checkoutController {

    private CheckoutService checkoutService;

    public  checkoutController(CheckoutService checkoutService) {
        this.checkoutService = checkoutService;
    }

    @PostMapping("/purchase")
    public PurchaseResponse placeOrder(@RequestBody Purchase purchase){

        return checkoutService.placeOrder(purchase);
    }

    @PostMapping("/payment-intent")
    public ResponseEntity<String> createPaymentIntent(@RequestBody PaymentInfo paymentInfo) throws StripeException {

        PaymentIntent paymentIntent = checkoutService.createPaymentIntent(paymentInfo);

        String paymentStr = paymentIntent.toJson();

        return new ResponseEntity<>(paymentStr, HttpStatus.OK);
    }
}
