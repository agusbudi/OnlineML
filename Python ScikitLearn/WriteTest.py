from sys import argv

script, filename = argv

print ("We are going to erase %r." % filename)
print ("If you don't want that, hit CTRL-C (^C).")
print ("If you do want that, hit RETURN.")

print ("Opening the file...")
target = open(filename, 'w')

print ("Truncating the file.  Goodbye!")
target.truncate()
target.write("We are going to erase %r." % filename)
target.write("\n")
target.write("Truncating the file.  Goodbye!")


print ("And finally, we close it.")
target.close()