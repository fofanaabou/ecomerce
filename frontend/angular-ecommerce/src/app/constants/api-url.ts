import { environment } from '../../environments/environment';

export class ApiUrl {
  static PRODUCTS = `${environment.baseUrl}/products` ;
  static PRODUCT_CATEGORY = `${environment.baseUrl}/product_category`;
  static SEARCH_PRODUCTS = ApiUrl.PRODUCTS + '/search/findByNameContainingIgnoreCase?name=';
}
