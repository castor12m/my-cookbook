export FLASK_APP=superset
export PYTHONPATH="${PYTHONPATH}:/src/config"

echo $FLASK_APP 

export FLASK_APP=superset;superset run -h 0.0.0.0 -p 8089 --with-threads --reload --debugger;
