import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {Product} from '../common/product';
import {ProductCategory} from '../common/product-category';
import {map} from 'rxjs/operators';

import { ApiUrl } from '../constants/api-url';

interface GetResponseProducts {
  _embedded: { products: Product[] };
}

interface GetResponseProductCategory {
  _embedded: { ProductCategory: ProductCategory[] };
}

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  constructor(private httpClient: HttpClient) { }

  getProductList(categoryId: number): Observable<Product[]> {

   // @TODO : NEED TO build URL on category id
   const searchUrl = `${ApiUrl.PRODUCTS}/search/findByCategoryId?id=${categoryId}`;
   return this.getProducts(searchUrl);
  }

  getProductCategories(): Observable<ProductCategory[]>{
         return this.httpClient.get<GetResponseProductCategory>(ApiUrl.PRODUCT_CATEGORY).pipe(
          map(response => response._embedded.ProductCategory)
         );
  }

  searchProducts(theKeyword: string): Observable<Product[]> {
    const searchUrl = `${ApiUrl.SEARCH_PRODUCTS}${theKeyword}`;
    return this.getProducts(searchUrl);
  }

  getProducts(url: string): Observable<Product[]>{
    return this.httpClient.get<GetResponseProducts>(url).pipe(
      map(response => response._embedded.products)
    );
  }

  getProduct(theProductId: number): Observable<Product>{

  // product urlconst s
  const url = `${ApiUrl.PRODUCTS}/${theProductId}`;
    return this.httpClient.get<Product>(url);
  }

}
