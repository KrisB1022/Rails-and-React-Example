import React from 'react';
import PropTypes from 'prop-types';

const Sitter = (props) => {
    return (
        <li className="row border sitter">
            <div
                className="col-md-3 sitterHeadshot"
                style={{
                    backgroundImage: `url(${props.image})`
                }}
            >
                <span className="sr-only">{props.name} headshot</span>
            </div>

            <div className="col-md-3">
                <h3 className="name">{props.name}</h3>
                <div>Ratings Score <span className="badge badge-info rating">{props.ratingsScore}</span></div>
            </div>
        </li>
    )
}

Sitter.propTypes = {
    image: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired,
    ratingsScore: PropTypes.number.isRequired
};

export default Sitter;
