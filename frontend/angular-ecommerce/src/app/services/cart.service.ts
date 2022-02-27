import { Injectable } from '@angular/core';
import { CartItem } from '../common/cart-item';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  cartItems: CartItem[] = [];

  totalPrice: BehaviorSubject<number> = new BehaviorSubject<number>(0);
  totalQuantity: BehaviorSubject<number> = new BehaviorSubject<number>(0);

  // storage: Storage = sessionStorage;
  storage: Storage = localStorage;

  constructor() {

    // read data from storage
    const data = JSON.parse(this.storage.getItem('cartItems'));

    if  ( data != null) {
      this.cartItems = data;

      // compute totals based on the data is read from storage
      this.computeCartTotal();
    }
  }

  addToCart(theCartItem: CartItem): void{
    let alreadyExistsInCart = false;
    let existingCartItem: CartItem;

    if (this.cartItems.length > 0){

      existingCartItem = this.cartItems.find(tempCartIem => tempCartIem.id === theCartItem.id);

      // check if we found item
      alreadyExistsInCart = (existingCartItem !== undefined);
    }


    if (alreadyExistsInCart){
        existingCartItem.quantity++;
      } else {
        this.cartItems.push(theCartItem);
      }

    this.computeCartTotal();
  }

  computeCartTotal(): void{
    let totalPriceValue = 0;
    let totalQuantityValue = 0;

    for (const currentCartItem of this.cartItems){
      totalPriceValue += currentCartItem.unitPrice * currentCartItem.quantity;
      totalQuantityValue += currentCartItem.quantity;
    }

    // publish the new value ... all subscribers will receive new data
    this.totalPrice.next(+parseFloat(`${totalPriceValue}`).toFixed(2));
    this.totalQuantity.next(totalQuantityValue);

    console.log('total:', totalPriceValue);

    // persist cart data
    this.persistCartItems();
  }

  remove(theCartItem): void{

    // get index of item in the array
    const itemIndex = this.cartItems.findIndex( tempCartItem => tempCartItem.id === theCartItem.id);

    if (itemIndex > -1) {
      this.cartItems.splice(itemIndex, 1);
      this.computeCartTotal();
    }
  }

  decrementQuantity(theCartItem: CartItem): void{

    theCartItem.quantity--;

    if (theCartItem.quantity === 0){
      this.remove(theCartItem);
    } else {
      this.computeCartTotal();
    }
  }

  persistCartItems(): void{
    this.storage.setItem('cartItems', JSON.stringify(this.cartItems));
  }

}
