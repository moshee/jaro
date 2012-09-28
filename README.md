# jaro

Yet another implementation of Jaro-Winkler string distance. Examples taken from wikipedia:
```ruby
puts "MARTHA" ^ "MARHTA"
puts "DWAYNE" ^ "DUANE"
puts "DIXON" ^ "DICKSONX"
```

outputs:

```
0.9611111111111111
0.8400000000000001
0.8133333333333332
```
