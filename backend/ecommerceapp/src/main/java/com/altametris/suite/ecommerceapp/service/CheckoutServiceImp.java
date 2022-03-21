package com.altametris.suite.ecommerceapp.service;

import com.altametris.suite.ecommerceapp.dao.CustomerRepository;
import com.altametris.suite.ecommerceapp.dto.PaymentInfo;
import com.altametris.suite.ecommerceapp.dto.Purchase;
import com.altametris.suite.ecommerceapp.dto.PurchaseResponse;
import com.altametris.suite.ecommerceapp.entity.Customer;
import com.altametris.suite.ecommerceapp.entity.Order;
import com.altametris.suite.ecommerceapp.entity.OrderItem;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class CheckoutServiceImp implements CheckoutService{

    private final CustomerRepository customerRepository;

    public CheckoutServiceImp(CustomerRepository customerRepository, @Value("${stripe.key.secret}") String secretKey){
        this.customerRepository = customerRepository;
    }

    @Override
    @Transactional
    public PurchaseResponse placeOrder(Purchase purchase) {

        // retrieve order info from purchase
        Order order = purchase.getOrder();

        // generate tracking number
        String orderTrackingNumber = generateOrderTrackingNUmber();
        order.setOrderTrackingNumber(orderTrackingNumber);

        // update billing address
        order.setBillingAddress(purchase.getBillingAddress());

        // update shipping address
        order.setShippingAddress(purchase.getShippingAddress());

        // populate order with orderItems
        Set<OrderItem> orderItems = purchase.getOrderItems();
        orderItems.forEach(order::add);

        // populate customer with order
        Customer customer = purchase.getCustomer();

        // check if this is an existing customer
        String theEmail = customer.getEmail();

        Customer customerFromDB = customerRepository.findByEmail(theEmail);

        if (customerFromDB != null) {
            // we found them ... let's assign them accordingly
            customer = customerFromDB;
        }
        customer.add(order);

        // save to database
        customerRepository.save(customer);

        // return a response
        return new PurchaseResponse(orderTrackingNumber);
    }

    @Override
    public PaymentIntent createPaymentIntent(PaymentInfo paymentInfo) throws StripeException {

        List<String> paymentMethodTypes = new ArrayList<>();
        paymentMethodTypes.add("card");

        Map<String, Object> params = new HashMap<>();
        params.put("amount",paymentInfo.getAmount());
        params.put("currency", paymentInfo.getCurrency());
        params.put("payment_method_types", paymentMethodTypes);
        return PaymentIntent.create(params);
    }

    private String generateOrderTrackingNUmber() {

        // generate a random UUID number (UUID version-4)
        // For details see: https://en.wikipedia.org/wiki/Universally_unique_identifier
        return UUID.randomUUID().toString().toUpperCase(Locale.ROOT);
    }
}
