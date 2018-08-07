import React from 'react';
import PropTypes from 'prop-types';

const Filters = (props) => {
    return (
        <form className="col-md-2">
            <div className="form-group">
                <label htmlFor="ratingsFilter">Ratings Filter</label>
                <select
                    onChange={(evt) => props.filterByProperty('ratingsScore', evt.target.value)}
                    className="form-control"
                    id="ratingsFilter">
                    
                    <option defaultValue value="default">All</option>
                    <option>5</option>
                    <option>4 and up</option>
                    <option>3 and up</option>
                    <option>2 and up</option>
                </select>
            </div>
        </form>
    )
};

Filters.propTypes = {
    filterByProperty: PropTypes.func.isRequired
}

export default Filters;
