require 'awesome_print'

f_name = ARGV[0]
top_line = ARGV[2].to_i - 30 >= 0 ? ARGV[2].to_i - 30 : 0
bottom_line = ARGV[2].to_i


cur_method_name = `awk '/def/ && NR >= #{top_line} && NR <= #{bottom_line}' lib/#{f_name}.rb`
parentheses_idx = cur_method_name.split("def")[-1].index("(")

cur_method_name =  cur_method_name.split("def")[-1][0...parentheses_idx][0...-1].strip

spec_folder = "#{ARGV[1]}/spec/"

spec_file = "#{spec_folder}01_#{f_name}_spec.rb"
line_num = `grep -n "##{cur_method_name}" #{spec_file}`
line_num.to_s

spec = "#{spec_file}:#{line_num.split(':')[0].to_i}"
dot_rspec = "#{ARGV[1]}/.rspec"

puts system("bundle exec rspec --options #{dot_rspec} #{spec}")