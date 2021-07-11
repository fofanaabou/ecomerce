import { Component, OnInit } from '@angular/core';
import { CartService } from '../../services/cart.service';

@Component({
  selector: 'app-cart-status',
  templateUrl: './cart-status.component.html',
  styleUrls: ['./cart-status.component.css']
})
export class CartStatusComponent implements OnInit {

  public totalQuantity: number = null
  public totalPrice: number = 0.00;

  constructor( private cartService: CartService) { }

  ngOnInit(): void {
    this.updateCartStatus();
  }

  updateCartStatus(){
     this.cartService.totalQuantity.subscribe(value => { this.totalQuantity = value;});
     this.cartService.totalPrice.subscribe(value => { this.totalPrice = value;})
  }

}
