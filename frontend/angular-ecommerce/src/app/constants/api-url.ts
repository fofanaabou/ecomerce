import { environment } from '../../environments/environment';

export class ApiUrl {
  static PRODUCTS = `${environment.baseUrl}/products` ;
  static PRODUCT_CATEGORY = `${environment.baseUrl}/product_category`;
  static SEARCH_PRODUCTS = ApiUrl.PRODUCTS + '/search/findByNameContainingIgnoreCase?name=';
  static COUNTRIES = `${environment.baseUrl}/countries`;
  static STATES = `${environment.baseUrl}/states`;
  static STATES_BY_COUNTRY = `${ApiUrl.STATES}/search/findByCountryCode?countryCode=`;
  static purchaseUrl = `${environment.baseUrl}/checkout/purchase`;
  static ORDER_URL = `${environment.baseUrl}/orders` ;
}
