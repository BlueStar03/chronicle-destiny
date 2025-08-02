---
title: Hello, World!
---
# Hello, World!

## Text Formatting

Besides *italics* and **bold**, you can also use:
- `Inline code` with backticks.
- ~~Strikethrough text~~ to show edits.
- A combination of **_bold and italic_**.

---

## Lists

### Ordered List
1.  First item
2.  Second item
    1.  A nested item
    2.  Another nested item
3.  Third item

### Task List
- [x] Learn basic Markdown syntax.
- [ ] Create a table.
- [ ] Add a footnote.

---

## Code Blocks

You can specify the programming language for syntax highlighting.

**Python**
```python
def greet(name):
  """This function greets the person passed in as a parameter."""
  print(f"Hello, {name}!")

greet("World")
````

**JavaScript**

```javascript
// A simple "Hello, World!" function in JavaScript
const greet = (name) => {
  console.log(`Hello, ${name}!`);
};

greet('World');
```

-----

## Blockquote

> "There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies. The first method is far more difficult."
>
> — C.A.R. Hoare

-----

## Table

Here's a simple table summarizing some features:

| Feature      | Syntax                 | Example                     |
|--------------|------------------------|-----------------------------|
| Heading      | `# Text`               | `# My Title`                |
| Blockquote   | `> Text`               | `> This is a quote.`        |
| Task List    | `- [ ] Task`           | `- [x] Finish demo`         |
| Strikethrough| `~~Text~~`             | `~~obsolete~~`              |

-----

## Extras

You can find more information at the [Markdown Guide](https://www.markdownguide.org). And here is a footnote for good measure.[^1]

```
```

[^1]:
    This is the footnote\! It provides extra information and appears at the very bottom of the rendered document.