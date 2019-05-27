def consolidate_cart(cart)
  new_hash = {}
  cart.each do |name_hash|
      name_hash.keys.each do |name|
            if !new_hash.key?(name)
                new_hash[name] = {}
                new_hash[name][:count] = 0
                new_hash[name] = new_hash[name].merge(name_hash[name])
            end
            new_hash[name][:count] += 1
      end   
  end
  new_hash  # code here
end

def apply_coupons(cart, coupons)
    new_hash = cart
    coupons.each do |info|
      if new_hash.key?(info[:item]) && new_hash[info[:item]][:count] >= info[:num]
        if !new_hash.key?("#{info[:item]} W/COUPON")
          new_hash["#{info[:item]} W/COUPON"] = {:price => info[:cost], :clearance => cart[info[:item]][:clearance], :count => 1}
        else
          new_hash["#{info[:item]} W/COUPON"][:count] += 1
        end
        new_hash[info[:item]][:count] -= info[:num]
        if new_hash[info[:item]][:count] == 0
          new_hash.delete([info[:item]])
        end
      end
    end   
    new_hash
end
      
  


  # code here

def apply_clearance(cart)
  cart.each do |name, info|
    if info[:clearance] == true
       info[:price] = (info[:price] * 0.80).round(2)
    end
  end
  cart
  # code here
end

def checkout(cart, coupons)
  consolidate_cart = consolidate_cart(cart)
  after_coupon = apply_coupons(consolidate_cart,coupons)
  after_discount = apply_clearance(after_coupon)
  total = 0
  after_discount.each do |name,info|
    total += info[:price] * info[:count]
  end
  if total > 100
    total = total * 0.9
  end
  total
end
  
    
    



  # code here
