import re
import json
import sys

def replace_newline_with_backtick_n(text):
    """
    Replace all instances of \n with `n in the given text.
    
    Parameters:
    text (str): The input text containing \n characters.
    
    Returns:
    str: The text with \n replaced by `n.
    """
    return text.replace('\n', '`n')

def remove_inside_parentheses(text):
    """
    Remove the content inside parentheses unless it's (clk) or (reset), or 
    there is a # before the parenthesis as in #().
    
    Parameters:
    text (str): The input text containing parentheses.
    
    Returns:
    str: The text with specific content inside parentheses removed.
    """
    def replace_match(match):
        content = match.group(1)
        if content in ('clk', 'reset') or match.group(0).startswith('#'):
            return match.group(0)
        return '()'

    return re.sub(r'(\(.*?\))', lambda m: replace_match(m), text)

def process_text(text):
    """
    Process the text by replacing \n with `n and removing content inside 
    parentheses with exceptions.
    
    Parameters:
    text (str): The input text to be processed.
    
    Returns:
    str: The processed text.
    """
    text = replace_newline_with_backtick_n(text)
    text = remove_inside_parentheses(text)
    return text

def main():
    """
    Main function to execute the text processing and save the result in a JSON file.
    Takes three system arguments: the input string, the path to the JSON file, 
    and the key name under which to save the processed text.
    """
    if len(sys.argv) != 4:
        print("Usage: python script.py <input_string> <json_file_path> <json_key>")
        sys.exit(1)

    input_string = sys.argv[1]
    json_file_path = sys.argv[2]
    json_key = sys.argv[3]

    processed_text = process_text(input_string)

    data = {json_key: processed_text}

    with open(json_file_path, 'w') as json_file:
        json.dump(data, json_file, indent=4)

if __name__ == "__main__":
    main()
