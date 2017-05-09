import app from './app';

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`API REST running on port ${port}`);
});
