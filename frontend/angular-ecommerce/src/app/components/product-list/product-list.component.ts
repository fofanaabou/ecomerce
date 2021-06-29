import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {ProductService} from '../../services/product.service';
import {Product} from '../../common/product';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list-grid.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  constructor(
    private productService: ProductService,
    private route: ActivatedRoute) { }
  public products: Product[];
  public currentCategoryId: number;
  public currentCategoryName: string;
  public searchMode: boolean;

  ngOnInit(): void {
  this.route.paramMap.subscribe(() => {
     this.listProducts();
  });
  }
  listProducts(): void {

    this.searchMode = this.route.snapshot.paramMap.has('keyword');

    if(this.searchMode) {
      this.handleSearchProducts();
    } else {
      this.handleListProducts();
    }

  }

  handleListProducts(){
    // if check if id paramater is available
        const hasCategoryId: boolean = this.route.snapshot.paramMap.has('id');

        if(hasCategoryId){
          // get the "id" param string and convert to number
          this.currentCategoryId = +this.route.snapshot.paramMap.get('id');

          // get the "name" param
          this.currentCategoryName = this.route.snapshot.paramMap.get('name');
        } else {
          this.currentCategoryId = 1;
          this.currentCategoryName = 'Books';
          }
      this.productService.getProductList(this.currentCategoryId).subscribe(data => {this.products = data });
  }

  handleSearchProducts(){
    const theKeyword = this.route.snapshot.paramMap.get('keyword');

    // search products using keyword
    this.productService.searchProducts(theKeyword).subscribe(data => {
      this.products = data;
    })
  }

}
