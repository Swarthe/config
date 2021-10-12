function tfnd --wraps='grep' --description 'Fuzzy text search'
  grep -Iri $argv .;
end
