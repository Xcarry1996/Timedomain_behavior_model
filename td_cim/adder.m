function output = adder(binary_vector)

sum = 0;

for i = 1:length(binary_vector)
    sum = sum + binary_vector(i)*pow2(length(binary_vector)-i);
end

output = sum;

end