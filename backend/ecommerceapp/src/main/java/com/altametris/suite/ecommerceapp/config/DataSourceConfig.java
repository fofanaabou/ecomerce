package com.altametris.suite.ecommerceapp.config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;

@Configuration
public class DataSourceConfig {

    @Bean
    public DataSource getDataSource() throws PropertyVetoException {
        final ComboPooledDataSource comboPooledDataSource = new ComboPooledDataSource();
        comboPooledDataSource.setDriverClass("org.postgresql.Driver");
        comboPooledDataSource.setJdbcUrl(System.getenv("DATABASE_URL"));
        comboPooledDataSource.setUser(System.getenv("DATABASE_USERNAME"));
        comboPooledDataSource.setPassword(System.getenv("DATABASE_PASSWORD"));

        // the pool
        comboPooledDataSource.setInitialPoolSize(5);
        comboPooledDataSource.setMinPoolSize(5);
        comboPooledDataSource.setMaxPoolSize(500);
        comboPooledDataSource.setNumHelperThreads(5);
        comboPooledDataSource.setAcquireIncrement(10);
        comboPooledDataSource.setMaxIdleTime(600);

        return comboPooledDataSource;
    }
}
