def plural
  if $students.length == 1
    return "" 
  else
    return "s"
  end
end
def save_students
  puts "Where do you want to save to? Type filename or leave blank for default (students.csv)."
  filename = gets.chomp
  filename = "students.csv" if filename.nil?
  file = File.open(filename, "w")
  $students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Saved to #{filename}."
end
def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{$students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end
def input_students
  puts "Please enter the names of the students, followed optionally by their cohort date in curved parentheses. (If no parentheses, default cohort is November.)"
  puts "To finish, return an empty input (with newline)."
  # create an empty array
  $students = []
  # get the first name
  input = STDIN.gets.chomp
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
    input = STDIN.gets.chomp
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
  puts "3. Save the current list"
  puts "4. Load the students saved before"
  puts "9. Exit"
end
def show_students
  print_header
  print_students_list
  print_footer($students)
end
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  counter = 0
  file.readlines.each do |line|
    counter += 1
    name, cohort = line.chomp.split(',')
    cohort.chomp!
    $students << {name: name, cohort: cohort.to_sym}
  end
  file.close
  puts "Loaded #{counter} more students from #{filename}."
end
def process
  selection = STDIN.gets.chomp
  case selection
    when "1"
      $students = input_students
    when "2"
      if $students.length > 0   
        show_students
      else
        puts "No students to display."
      end
    when "3"
      save_students
    when "4"
      try_load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
end
def interactive_menu
  $students = []
  try_load_students
  loop do
    print_menu
    process
  end
end

interactive_menu