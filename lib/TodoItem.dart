class TodoItem
{
  String _itemName;
  bool _isComplete = false;

  TodoItem(this._itemName);

  getItemName() => this._itemName;
  setItemName(itemName)=> this._itemName = itemName;

  getIsComplete() => this._isComplete;
  setIsComplete(isComplete) => this._isComplete = isComplete;
}