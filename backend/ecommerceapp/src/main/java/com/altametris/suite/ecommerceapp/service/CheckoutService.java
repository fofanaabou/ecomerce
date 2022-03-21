package com.altametris.suite.ecommerceapp.service;

import com.altametris.suite.ecommerceapp.dto.PaymentInfo;
import com.altametris.suite.ecommerceapp.dto.Purchase;
import com.altametris.suite.ecommerceapp.dto.PurchaseResponse;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import org.springframework.stereotype.Service;

@Service
public interface CheckoutService {

    PurchaseResponse placeOrder(Purchase purchase);

    PaymentIntent createPaymentIntent(PaymentInfo paymentInfo) throws StripeException;
}
