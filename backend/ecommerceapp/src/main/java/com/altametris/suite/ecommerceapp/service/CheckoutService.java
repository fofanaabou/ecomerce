package com.altametris.suite.ecommerceapp.service;

import com.altametris.suite.ecommerceapp.dto.Purchase;
import com.altametris.suite.ecommerceapp.dto.PurchaseResponse;
import org.springframework.stereotype.Service;

@Service
public interface CheckoutService {

    PurchaseResponse placeOrder(Purchase purchase);
}
