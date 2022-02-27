import { Injectable } from '@angular/core';
import {Observable, of} from 'rxjs';
import {HttpClient} from '@angular/common/http';
import {Country} from '../common/country';
import {ApiUrl} from '../constants/api-url';
import {map} from 'rxjs/operators';
import {State} from '../common/state';



@Injectable({
  providedIn: 'root'
})
export class ShopFormService {

  constructor(private httpClient: HttpClient) {
  }
  getCountries(): Observable<Country[]> {
    return this.httpClient.get<GetResponseCountries>(ApiUrl.COUNTRIES).pipe(
      map(response => response._embedded.countries));
  }
  getStates(): Observable<State[]> {
    return this.httpClient.get<GetResponseStates>(ApiUrl.STATES).pipe(
      map(response => response._embedded.states));
  }
  getStatesByCountryCode(countryCode: string): Observable<State[]> {
    return this.httpClient.get<GetResponseStates>(ApiUrl.STATES_BY_COUNTRY + countryCode).pipe(
      map(response => response._embedded.states));
  }
  getCreditCardMonths(startMonth: number): Observable<number[]> {

    const data: number[] = [];
    for (let theMonth = startMonth; theMonth <= 12; theMonth++){
      data.push(theMonth);
    }

    return of(data);
  }

  getCreditCardYears(): Observable<number[]> {

    const data: number[] = [];

    const startYear: number = new Date().getFullYear();
    const endYear: number = startYear + 10;

    for (let theYear = startYear; theYear <= endYear; theYear++){
      data.push(theYear);
    }
    return of(data);
  }
}

interface GetResponseCountries {
  _embedded: {
    countries: Country[];
  };
}

interface GetResponseStates {
  _embedded: {
    states: State[];
  };
}
