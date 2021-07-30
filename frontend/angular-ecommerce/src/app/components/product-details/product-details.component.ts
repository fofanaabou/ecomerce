import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';

import {Product} from '../../common/product';
import {CartItem} from '../../common/cart-item';
import {ProductService} from '../../services/product.service';
import { CartService } from '../../services/cart.service';

@Component({
  selector: 'app-product-details',
  templateUrl: './product-details.component.html',
  styleUrls: ['./product-details.component.css']
})
export class ProductDetailsComponent implements OnInit {

  public product = new Product();

  constructor(
  private productService: ProductService,
  private cartService: CartService,
  private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.route.paramMap.subscribe(() => {
      this.handleProductDetails();
    })
  }

  handleProductDetails() {
    const theProductId: number = +this.route.snapshot.paramMap.get('id');

    this.productService.getProduct(theProductId).subscribe(data => {
      this.product = data;
    })
  }

  addToCart(theProduct: Product) {

    const theCartItem = new CartItem(theProduct);
    this.cartService.addToCart(theCartItem);
    console.log(`Adding to cart:`, theProduct);

  }


}
