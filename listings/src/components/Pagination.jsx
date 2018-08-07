import React, { Component } from 'react';
import PropTypes from 'prop-types';

class Pagination extends Component {
    pageEnum() {
        return Array.from(Array(this.props.totalPages + 1).keys()).splice(1);
    }

    listItem({ classCondition, copy, page, truthyClass='disabled' }) {
        return (
            <li 
                key={`page_${copy}`} 
                className={`page-item ${classCondition ? truthyClass : ''}`}
            >
                <a 
                    className="page-link"
                    onClick={() => this.props.setPageHandler(page)}>
                    {copy}
                </a>
            </li>
        );
    }

    render() {
        return (
            <nav 
                aria-label="Sitter listings page navigation" 
                className="paginationWrapper"
            >
                <ul className="pagination justify-content-center">
                    {this.listItem({
                        classCondition: this.props.currentPage === 1,
                        copy: 'First',
                        page: 1
                    })}

                    {this.listItem({
                        classCondition: this.props.currentPage === 1,
                        copy: 'Previous',
                        page: this.props.currentPage - 1
                    })}

                    {this.pageEnum().map((page) => {
                        return (
                            this.listItem({
                                page,
                                classCondition: this.props.currentPage === page,
                                copy: page,
                                truthyClass: 'active'
                            })
                        )
                    })}
                        
                    {this.listItem({
                        classCondition: this.props.currentPage === this.props.totalPages,
                        copy: 'Next',
                        page: this.props.currentPage + 1
                    })}

                    {this.listItem({
                        classCondition: this.props.currentPage === this.props.totalPages,
                        copy: 'Last',
                        page: this.props.totalPages
                    })}
                </ul>
          </nav>
        )
    }
}

Pagination.propTypes = {
    currentPage: PropTypes.number.isRequired,
    totalPages: PropTypes.number.isRequired,
    setPageHandler: PropTypes.func.isRequired
}

export default Pagination;
