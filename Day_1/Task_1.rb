require 'json'
class Inventory
    Books = []
    def add_book(title, author)
        book = {ISBN: Books.length + 1, title: title, author: author}
        Books.push(book)
        File.open('./DB.json', 'w') do |f|
            f.write(JSON.pretty_generate(Books))
        end
    end

    def get_book()
        File.open('./DB.json', 'r') do |f|
            books = f.read
            books = JSON.parse(books)
            return books
        end
    end

    def list_all_books
        # puts Books.length
        File.open('./DB.json', 'r') do |f|
            all_books = f.read
            all_books = JSON.parse(all_books)
            all_books.each do |book|
                puts "ISBN: #{book['ISBN']} Title: #{book['title']}, Author: #{book['author']}"
            end
        end
    end

    def remove_book_by_isbn(isbn)
        books = get_book()
        books.each do |b|
            book_isbn = b["ISBN"].to_i
            if book_isbn == isbn
                books.delete(b)
                File.open('./DB.json', 'w') do |f|
                    f.write(JSON.pretty_generate(books))
                end
            end
        end
    end

    def search_books_by_isbn(isbn)
        books = get_book()
        books.each do |b|
            book_isbn = b["ISBN"].to_i
            if book_isbn == isbn
                puts "ISBN: #{b['ISBN']} Title: #{b['title']}, Author: #{b['author']}"
            end
        end
    end


    def search_books_by_title(title)
        books = get_book()
        books.each do |b|
            book_title = b["title"]
            if book_title == title
                puts "ISBN: #{b['ISBN']} Title: #{b['title']}, Author: #{b['author']}"
            end
        end
    end

    def search_books_by_author(author)
        books = get_book()
        books.each do |b|
            book_author = b["author"]
            if book_author == author
                puts "ISBN: #{b['ISBN']} Title: #{b['title']}, Author: #{b['author']}"
            end
        end
    end

    def menu()
        puts "1. Add a book"
        puts "2. List all books"
        puts "3. Remove a book by ISBN"
        puts "4. Search for books by ISBN"
        puts "5. Search for books by title"
        puts "6. Search for books by author"
        puts "7. Exit"
        puts "Enter your choice: "
        choice = gets.chomp.to_i
        case choice
        when 1
            puts "Enter title: "
            title = gets.chomp
            puts "Enter author: "
            author = gets.chomp
            add_book(title, author)
            puts "Book added successfully"
            menu()
        when 2
            books = get_book()
            if books.length == 0
                puts "No books found"
            end
            puts "All books:"
            list_all_books
            menu()
        when 3
            puts "Enter ISBN: "
            isbn = gets.chomp.to_i
            File.open('./DB.json', 'r') do |f|
                book = f.read
                book = JSON.parse(book)
                book.each do |b|
                    puts b
                    book_isbn = b["ISBN"].to_i
                    if book_isbn == isbn
                        remove_book_by_isbn(isbn)
                        puts "Book removed successfully"
                    else
                        puts "Book not found"
                    end
                end
            end

            menu()
        when 4
            puts "Enter ISBN: "
            isbn = gets.chomp.to_i
            books = get_book()
            books.each do |b|
                book_isbn = b["ISBN"].to_i
                if book_isbn == isbn
                    search_books_by_isbn(isbn)
                    puts "Book found"
                else
                    puts "Book not found"
                end
            end
            menu()
        when 5
            puts "Enter title: "
            title = gets.chomp
            books = get_book()
            books.each do |b|
                book_title = b["title"]
                if book_title == title
                    search_books_by_title(title)
                    puts "Book found"
                else
                    puts "Book not found"
                end
            end
            menu()
        when 6
            puts "Enter author: "
            author = gets.chomp
            books = get_book()
            books.each do |b|
                book_author = b["author"]
                if book_author == author
                    search_books_by_author(author)
                    puts "Book found"
                else
                    puts "Book not found"
                end
            end
            menu()
        when 7
            exit
        else
            puts "Invalid choice"
            menu()
        end
    end
end

inventory = Inventory.new
inventory.menu()
