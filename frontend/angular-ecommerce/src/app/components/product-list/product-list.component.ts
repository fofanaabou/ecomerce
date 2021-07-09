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
    private route: ActivatedRoute
  ) { }

  public products: Product[] = [];
  public currentCategoryId: number = 1;
  public previousCategoryId: number = 1;
  public currentCategoryName: string;
  public searchMode: boolean = false;

  public thePageNumber: number = 1;
  public thePageSize: number = 5;
  public theTotalElements: number = 0;

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

      // check if we have a different category than previous
      
      // Note; Angular will reuse a component if it is currently being viewed

      // if we have a different category id than previous
      // then set thePageNumber back to 1
      if(this.previousCategoryId !==this.currentCategoryId){
        this.thePageNumber = 1;
      }

      this.previousCategoryId = this.currentCategoryId;

      console.log('currentCategoryId:', this.currentCategoryId, 'pageNumber:', this.thePageNumber);

      this.productService.getProductListPaginate(this.thePageNumber-1, this.thePageSize, this.currentCategoryId).subscribe(this.processResult());
  }

  handleSearchProducts(){
    const theKeyword = this.route.snapshot.paramMap.get('keyword');

    // search products using keyword
    this.productService.searchProducts(theKeyword).subscribe(data => {
      this.products = data;
    })
  }

  processResult(){ 
    return data => {
      this.products = data._embedded.products;
      this.thePageNumber = data.page.number + 1;
      this.thePageSize = data.page.size;
      this.theTotalElements = data.page.totalElements;
    };
  }

  updatePageSize(pageSize: number) {
    this.thePageSize = pageSize;
    this.thePageNumber = 1;
    this.listProducts();
  }

}
