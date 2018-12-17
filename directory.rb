def plural
  if $students.length == 1
    return "" 
  else
    return "s"
  end
end
def input_students
  puts "Please enter the names of the students, followed optionally by their cohort date in curved parentheses. (If no parentheses, default cohort is November.)"
  puts "To finish, return an empty input (with newline)."
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
def print_students_list
  $students.sort_by! { |student| student[:cohort]}
  $students.each.with_index do |student, i|
    puts "#{i+1}. #{student[:name].capitalize} (#{student[:cohort].capitalize})"
  end
end
def print_footer(names)
  puts
  puts "In sum, we have #{names.count} great student#{plural}"
end
def print_menu
  puts "*** MENU:"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more items  
end
def show_students
  print_header
  print_students_list
  print_footer($students)
end
def interactive_menu
  $students = []
  loop do
    # 1. print the menu and ask the user what to do
    print_menu
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      $students = input_students
    when "2"
      if $students.length > 0   
        show_students
      else
        puts "No students to display."
      end
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu