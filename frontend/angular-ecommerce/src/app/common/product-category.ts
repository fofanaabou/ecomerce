export class ProductCategory {
  constructor(private _id: number, private _categoryName: string){}

  public get id() {
    return this._id;
  }
  /**
  @param value
  **/
  public set id(value: number) {
    this._id = value;
  }

  public get categoryName() {
    return this._categoryName;
  }

  /**
  @parma value
  **/
  public set categoryName (value: string) {
    this._categoryName = value;
  }
}
