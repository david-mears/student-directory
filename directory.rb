def plural
  if $students.length == 1
    return "" 
  else
    return "s"
  end
end
def input_students
  puts "Please enter the names of the students, followed optionally by their cohort date in curved parentheses. (If no parentheses, default cohort is November.)"
  puts "To finish, just hit return twice"
  # create an empty array
  $students = []
  # get the first name
  input = gets.chomp
  # while the name is not empty, repeat this code
  while !input.empty? do
    # add the student hash to the array
    cohort = :november
    if (input.include? "(") && (input.include? ")")
      open_paren = input.index('(')
      close_paren = input.index(')')
      cohort = input[open_paren+1...close_paren]
      name = input[0...open_paren]
      $students << {name: name, cohort: cohort.to_sym}
    else
      $students << {name: input, cohort: :november}
    end
    puts "Now we have #{$students.count} student#{plural}"
    # get another name from the user
    input = gets.chomp
  end
  # return the array of students
  $students
end
def print_header
  firstline = "The student#{plural} of Villains Academy"
  puts firstline.center(100)
  puts ("-" * firstline.length).center(100)
end
def print(students)
  $students.each.with_index do |student, i|
    puts "#{i+1}. #{student[:name].capitalize} (#{student[:cohort].capitalize})"
  end
end
def print_footer(names)
  puts
  puts "In sum, we have #{names.count} great student#{plural}"
end

$students = input_students
print_header
print($students)
print_footer($students)