import { Injectable } from '@angular/core';
import { CartItem } from '../common/cart-item';
import { Subject, BehaviorSubject } from 'rxjs';
import { temporaryDeclaration } from '@angular/compiler/src/compiler_util/expression_converter';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  cartItems: CartItem[] = [];

  totalPrice: BehaviorSubject<number> = new BehaviorSubject<number>(0);
  totalQuantity: BehaviorSubject<number> = new BehaviorSubject<number>(0);

  constructor() { }

  addToCart(theCartItem: CartItem){
    let alreadyExistsInCart: boolean = false;
    let existingCartItem: CartItem = undefined;

    if(this.cartItems.length > 0){

      existingCartItem = this.cartItems.find(tempCartIem => tempCartIem.id === theCartItem.id);

      // check if we found item
      alreadyExistsInCart = (existingCartItem != undefined);
    }


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
  
  remove(theCartItem){

    // get index of item in the array
    const itemIndex = this.cartItems.findIndex( tempCartItem => tempCartItem.id === theCartItem.id);

    if(itemIndex > -1) {
      this.cartItems.splice(itemIndex, 1);
      this.computeCartTotal();
    }
  }

  decrementQuantity(theCartItem: CartItem){

    theCartItem.quantity--;

    if(theCartItem.quantity === 0){
      this.remove(theCartItem);
    } else {
      this.computeCartTotal();
    }
  }

}
