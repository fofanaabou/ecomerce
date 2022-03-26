import { Injectable } from '@angular/core';
import {ApiUrl} from '../constants/api-url';
import {HttpClient} from '@angular/common/http';
import {Purchase} from '../common/purchase';
import {Observable} from 'rxjs';
import {PaymentInfo} from '../common/payment-info';

@Injectable({
  providedIn: 'root'
})
export class CheckoutService {

  private purchaseUrl = ApiUrl.purchaseUrl;
  private paymentUrl = ApiUrl.PAYMENT_URL;

  constructor(private httpClient: HttpClient) { }

  placeOrder(purchase: Purchase): Observable<any> {
    return this.httpClient.post<Purchase>(this.purchaseUrl, purchase);
  }

  createPayment(paymentInfo: PaymentInfo): Observable<any>{
    return this.httpClient.post<PaymentInfo>(this.paymentUrl, paymentInfo);
  }
}
