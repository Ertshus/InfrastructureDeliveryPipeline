from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Replace 'your_database_connection_string' with the actual connection string
app.config['SQLALCHEMY_DATABASE_URI'] = 'your_database_connection_string'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        first_name = request.form['first_name']
        last_name = request.form['last_name']

        new_user = User(first_name=first_name, last_name=last_name)
        db.session.add(new_user)
        db.session.commit()

        return redirect(url_for('index'))

    users = User.query.all()
    return render_template('index.html', users=users)

if __name__ == '__main__':
    db.create_all()
    app.run(host='0.0.0.0', port=5000)
