package com.altametris.suite.ecommerceapp.dao;

import com.altametris.suite.ecommerceapp.entity.State;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.RequestParam;

@RepositoryRestResource
public interface StateRepository extends JpaRepository<State, Integer> {
    Page<State> findByCountryCode(@RequestParam("countryCode") String countryCode, Pageable pageable);
}
