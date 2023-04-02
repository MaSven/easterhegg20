

## Docker 

You can build the reveal presentation with the following command:

```bash
docker build -t emacs ./docker
docker run --rm -v $(pwd):/presi emacs "/presi/presentation.org"
```