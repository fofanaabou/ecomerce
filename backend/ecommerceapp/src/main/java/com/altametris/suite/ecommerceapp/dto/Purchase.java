package com.altametris.suite.ecommerceapp.dto;

import com.altametris.suite.ecommerceapp.entity.Address;
import com.altametris.suite.ecommerceapp.entity.Customer;
import com.altametris.suite.ecommerceapp.entity.Order;
import com.altametris.suite.ecommerceapp.entity.OrderItem;
import lombok.Data;

import java.util.Set;

@Data
public class Purchase {

    private Customer customer;

    private Address billingAddress;

    private Address shippingAddress;

    private Order order;

    private Set<OrderItem> orderItems;
}
