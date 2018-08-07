import React from 'react';
import PropTypes from 'prop-types';
import Sitter from './Sitter';

const Sitters = (props) => {
    return (
        <ul className="sittersWrapper">
            { props.sitters.map((sitter) => {
                const { attributes } = sitter;

                return (
                    <Sitter 
                        key={sitter.id}
                        name={attributes.name}
                        image={attributes.image}
                        ratingsScore={attributes.ratingsScore}
                    />
                );
            })}
        </ul>
    );
};

Sitters.propTypes = {
    sitters: PropTypes.arrayOf(PropTypes.shape({
        id: PropTypes.string.isRequired,
        attributes: PropTypes.shape({
            image: PropTypes.string.isRequired,
            name: PropTypes.string.isRequired,
            ratingsScore: PropTypes.number.isRequired
        })
    }))
};

export default Sitters;
