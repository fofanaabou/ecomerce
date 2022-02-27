import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import {ShopFormService} from '../../services/shop-form.service';
import {CartService} from '../../services/cart.service';
import {Country} from '../../common/country';
import {State} from '../../common/state';
import {AppShopValidators} from '../../validators/app-shop-validators';
import {CheckoutService} from '../../services/checkout.service';
import {Router} from '@angular/router';
import {Order} from '../../common/order';
import {OrderItem} from '../../common/order-item';
import {Purchase} from '../../common/purchase';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {

  public checkoutFormGroup: FormGroup;
  public totalPrice = 0;
  public totalQuantity = 0;

  public creditYears: number[] = [];
  public creditMonths: number[] = [];
  public countries: Country[];
  public states: State[];
  public shippingAddressStates: State[];
  public billingAddressStates: State[];

  storage: Storage = sessionStorage;

  constructor(
    private formBuilder: FormBuilder,
    private shopFormService: ShopFormService,
    private cartService: CartService,
    private checkoutService: CheckoutService,
    private router: Router) { }

  ngOnInit(): void {
    // read the user's email address from storage
    const theEmail = JSON.parse(this.storage.getItem('userEmail'));
    const tempControl = this.formBuilder.group({
        street: new FormControl('', [Validators.required, Validators.minLength(2), AppShopValidators.notOnlyWhitespace]),
        city: new FormControl('', [Validators.required, Validators.minLength(2), AppShopValidators.notOnlyWhitespace]),
        state: new FormControl('', [Validators.required]),
        country: new FormControl('', [Validators.required]),
        zipCode: new FormControl('', [Validators.required, Validators.minLength(2), AppShopValidators.notOnlyWhitespace])
      });

    this.checkoutFormGroup = this.formBuilder.group({
      customer: this.formBuilder.group({
        firstName: new FormControl('', [Validators.required,
          Validators.minLength(2), AppShopValidators.notOnlyWhitespace]),
        lastName: new FormControl('', [Validators.required,
          Validators.minLength(2), AppShopValidators.notOnlyWhitespace]),
        email: new FormControl(theEmail, [Validators.required,
          Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')])
      }),
      shippingAddress: tempControl,
      billingAddress: tempControl,
      creditCard: this.formBuilder.group({
        cardType: new FormControl('', [Validators.required]),
        nameOnCard: new FormControl('', [Validators.required,
          Validators.minLength(2), AppShopValidators.notOnlyWhitespace]),
        cardNumber: new FormControl('', [Validators.required,
          Validators.pattern('[0-9]{16}')]),
        securityCode: new FormControl('', [Validators.required,
          Validators.pattern('[0-9]{3}')]),
        expirationMonth: [''],
        expirationYear: ['']
      })
    });

    const startMonth: number = new Date().getMonth() + 1;
    console.log('month:', startMonth);
    this.shopFormService.getCreditCardMonths(startMonth).subscribe(data => {
      console.log('Retriew credit card months');
      this.creditMonths = data;
    });

    this.shopFormService.getCreditCardYears().subscribe(data => {
      this.creditYears = data;
    });

    this.reviewCardDetail();

    // populate countries
    this.shopFormService.getCountries().subscribe(data => {
      this.countries = data;
    });
    // populate states
    this.shopFormService.getStates().subscribe(data => {
      this.states = data;
    });
  }
  get firstName(): any {
    return this.checkoutFormGroup.get('customer.firstName');
  }

  get lastName(): any {
    return this.checkoutFormGroup.get('customer.lastName');
  }
  get email(): any {
    return this.checkoutFormGroup.get('customer.email');
  }
  get shippingAddressStreet(): any {
    return this.checkoutFormGroup.get('shippingAddress.street');
  }
  get shippingAddressCity(): any {
    return this.checkoutFormGroup.get('shippingAddress.city');
  }
  get shippingAddressState(): any {
    return this.checkoutFormGroup.get('shippingAddress.state');
  }
  get shippingAddressCountry(): any {
    return this.checkoutFormGroup.get('shippingAddress.country');
  }
  get shippingAddressZipCode(): any {
    return this.checkoutFormGroup.get('shippingAddress.zipCode');
  }

  get billingAddressStreet(): any {
    return this.checkoutFormGroup.get('billingAddress.street');
  }
  get billingAddressCity(): any {
    return this.checkoutFormGroup.get('billingAddress.city');
  }
  get billingAddressState(): any {
    return this.checkoutFormGroup.get('billingAddress.state');
  }
  get billingAddressCountry(): any {
    return this.checkoutFormGroup.get('billingAddress.country');
  }
  get billingAddressZipCode(): any {
    return this.checkoutFormGroup.get('billingAddress.zipCode');
  }

  get creditCardType(): any {
    return this.checkoutFormGroup.get('creditCard.cardType');
  }
  get creditCardNameOnCard(): any {
    return this.checkoutFormGroup.get('creditCard.nameOnCard');
  }
  get creditCardNumber(): any {
    return this.checkoutFormGroup.get('creditCard.cardNumber');
  }
  get creditCardSecurityCode(): any {
    return this.checkoutFormGroup.get('creditCard.securityCode');
  }

  onSubmit(): void {
    if (this.checkoutFormGroup.invalid){
      this.checkoutFormGroup.markAllAsTouched();
      return;
    }
    // set up order
    const order = new Order();
    order.totalPrice = this.totalPrice;
    order.totalQuantity = this.totalQuantity;
    // get cart items
    const cartItems = this.cartService.cartItems;
    // create orderItems from cartItems
    // - long way
    // tslint:disable-next-line:prefer-const
    /* let orderItems: OrderItem[];
    // tslint:disable-next-line:prefer-for-of
    for (let i = 0; i < cartItems.length; i++){
      orderItems.push(new OrderItem(cartItems[i]));
    }*/

    // short way
    const orderItemShorts = cartItems.map(tempCartItem => new OrderItem(tempCartItem));
    // set up purchase
    const purchase = new Purchase();
    // populate purchase - customer
    purchase.customer = this.checkoutFormGroup.controls.customer.value;

    // populate purchase - billingAddress
    purchase.billingAddress = this.checkoutFormGroup.controls.billingAddress.value;
    const billingState: State = JSON.parse(JSON.stringify(purchase.billingAddress.state));
    const billingCountry: Country = JSON.parse(JSON.stringify(purchase.billingAddress.country));
    purchase.billingAddress.state = String(billingState.name);
    purchase.billingAddress.country = billingCountry.name;

    // populate purchase - shippingAddress
    purchase.shippingAddress = this.checkoutFormGroup.controls.shippingAddress.value;
    const shippingState: State = JSON.parse(JSON.stringify(purchase.shippingAddress.state));
    const shippingCountry: Country = JSON.parse(JSON.stringify(purchase.shippingAddress.country));
    purchase.shippingAddress.state = String(shippingState.name);
    purchase.shippingAddress.country = shippingCountry.name;

    // populate purchase - order and order items
    purchase.order = order;
    purchase.orderItems = orderItemShorts;
    // call REST API via the checkout
    this.checkoutService.placeOrder(purchase).subscribe({
      next: response => {
        alert(`Your order has been received. \nOrder tracking number: ${response.orderTrackingNumber}`);

        // reset cart
        this.resetCart();
        },
      error: err => { alert(`There an error: ${err.message}`); }
    });
  }
  copyShippingAddressToBillingAddress(event): void{
    if (event.target.checked){
      this.checkoutFormGroup.controls.billingAddress.setValue(this.checkoutFormGroup.controls.shippingAddress.value);

      // bug fix for states
      this.billingAddressStates = this.shippingAddressStates;
    } else {
      this.checkoutFormGroup.controls.billingAddress.reset();

      // bug fix for states
      this.billingAddressStates = [];
    }
  }

  handleMonthsAndYears(): void {
    const creditCardFormGroup = this.checkoutFormGroup.get('creditCard');

    const currentYear: number = new Date().getFullYear();
    const selectedYear: number = Number(creditCardFormGroup.value.expirationYear);
    let startMonth: number;

    if (currentYear === selectedYear) {
      startMonth = new Date().getMonth() + 1;
    } else {
      startMonth = 1;
    }

    this.shopFormService.getCreditCardMonths(startMonth).subscribe( data => {
      this.creditMonths = data;
    });
    console.log();
  }

  getStates(formGroupName: string): void {
    const formGroup = this.checkoutFormGroup.get(formGroupName);

    const countryCode = formGroup.value.country.code;
    const countryName = formGroup.value.country.name;

    this.shopFormService.getStatesByCountryCode(countryCode).subscribe(data => {
      if (formGroupName === 'shippingAddress'){
        this.shippingAddressStates = data;
      } else {
        this.billingAddressStates = data;
      }

      // select first item by defaut
      formGroup.get('state').setValue(data[0]);
    });
  }

  reviewCardDetail(): void {
    this.cartService.totalPrice.subscribe(totalPrice => { this.totalPrice = totalPrice; });
    this.cartService.totalQuantity.subscribe(totalQuantity => { this.totalQuantity = totalQuantity; });
  }

  private  resetCart(): void {
    // reset cart data
    this.cartService.cartItems = [];
    this.cartService.totalPrice.next(0);
    this.cartService.totalQuantity.next(0);

    // reset the form
    this.checkoutFormGroup.reset();

    // navigate to the product page
    this.router.navigateByUrl('/products').then(r => r);
  }
}
