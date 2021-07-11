import { Injectable } from '@angular/core';
import { CartItem } from '../common/cart-item';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  cartItems: CartItem[] = [];

  totalPrice: Subject<number> = new Subject<number>();
  totalQuantity: Subject<number> = new Subject<number>();

  constructor() { }

  addToCart(theCartItem: CartItem){
    let alreadyExistsInCart: boolean = false;
    let existingCartItem: CartItem = undefined;

    if(this.cartItems.length > 0){

      for(let tempCartItem of this.cartItems){
        if(tempCartItem.id === theCartItem.id) {
          existingCartItem = tempCartItem;
          break;
        }
      }
    }
      // check if we found item
      alreadyExistsInCart = (existingCartItem != undefined);

      if(alreadyExistsInCart){
        existingCartItem.quantity++;
      } else {
        this.cartItems.push(theCartItem);
      }

      this.computeCartTotal();
  }

  computeCartTotal(){
    let totalPriceValue: number = 0;
    let totalQuantityValue: number = 0;

    for(let currentCartItem of this.cartItems){
      totalPriceValue += currentCartItem.unitPrice*currentCartItem.quantity;
      totalQuantityValue += currentCartItem.quantity;
    }

    // publish the new value ... all subscribers will receive new data
    this.totalPrice.next(+parseFloat(`${totalPriceValue}`).toFixed(2));
    this.totalQuantity.next(totalQuantityValue);

    console.log('total:', totalPriceValue);
  }

}
