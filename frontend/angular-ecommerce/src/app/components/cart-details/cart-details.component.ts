import { Component, OnInit } from '@angular/core';
import { CartItem } from 'src/app/common/cart-item';
import { CartService } from 'src/app/services/cart.service';

@Component({
  selector: 'app-cart-details',
  templateUrl: './cart-details.component.html',
  styleUrls: ['./cart-details.component.css']
})
export class CartDetailsComponent implements OnInit {

  public cartItems: CartItem[] = [];
  public totalPrice: number = 0;
  public totalQuantity: number = 0;


  constructor(
    private cartService: CartService,
  ) { }

  ngOnInit(): void {
    this.listCartDetails();
  }

  listCartDetails(){

    this.cartItems = this.cartService.cartItems;

    // total price
    this.cartService.totalPrice.subscribe(data => this.totalPrice = data);

    // total quantity 
    this.cartService.totalQuantity.subscribe(data => this.totalQuantity = data);
  }

  incrementQuantity(theCartItem: CartItem) {
    this.cartService.addToCart(theCartItem);
  }

  decrementQuantity(theCartItem: CartItem){
    this.cartService.decrementQuantity(theCartItem);
  }

  remove(theCartItem: CartItem){
    this.cartService.remove(theCartItem);
  }
  

}
