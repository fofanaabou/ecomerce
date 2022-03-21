import { Injectable } from '@angular/core';
import {HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {from, Observable} from 'rxjs';
import {ApiUrl} from '../constants/api-url';
import {OktaAuthService} from '@okta/okta-angular';

@Injectable({
  providedIn: 'root'
})
export class AuthInterceptorService implements HttpInterceptor{

  constructor(private oktaAuth: OktaAuthService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return from(this.handleAccess(req, next));
  }

  private async handleAccess(request: HttpRequest<any>, next: HttpHandler): Promise<HttpEvent<any>>{

    // Only add an access token for secured endpoints
    const securedEndpoints = [`${ApiUrl.ORDER_URL}`];
    if (securedEndpoints.some(url => request.urlWithParams.includes(url))){

      // get access token
      const accessToken = await this.oktaAuth.getAccessToken();

      // clone the request and add new header with access
      request = request.clone({
        setHeaders: {
          Authorization: 'Bearer ' + accessToken
        }
      });
    }

    return next.handle(request).toPromise();
  }
}
