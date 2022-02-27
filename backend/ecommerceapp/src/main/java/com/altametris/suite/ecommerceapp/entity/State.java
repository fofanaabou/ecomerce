package com.altametris.suite.ecommerceapp.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "state")
public class State {

    @Id
    @SequenceGenerator(name = "state_id_seq", sequenceName = "state_id_seq", allocationSize = 1, initialValue = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "state_id_seq")
    private int id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "country_id")
    private Country country;

}
